# Copyright © 2021 Pavel Tisnovsky, Red Hat, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

"""Implementation of test steps that run CCX Notification Writer and check its output."""

from behave import given, when, then
import subprocess

# default name of file generated by CCX Notification Writer during testing
test_output = "test"


def process_ccx_notification_writer_output(context, out, return_code):
    """Process CCX Notification Writer output."""
    assert out is not None

    # interact with the process:
    # read data from stdout and stderr, until end-of-file is reached
    stdout, stderr = out.communicate()

    # basic checks
    assert stderr is None, "Error during check"
    assert stdout is not None, "No output from application"

    # check the return code of a process
    assert (
        out.returncode == 0 or out.returncode == return_code
    ), "Return code is {}".format(out.returncode)

    # try to decode output
    output = stdout.decode("utf-8").split("\n")

    assert output is not None

    # update testing context
    context.output = output
    context.stdout = stdout
    context.stderr = stderr
    context.returncode = out.returncode


@when(u"I start the CCX Notification Writer with the {flag} command line flag")
def start_ccx_notification_writer_with_flag(context, flag):
    """Start the CCX Notification Writer with given command-line flag."""
    out = subprocess.Popen(
        ["ccx-notification-writer", flag],
        stdout=subprocess.PIPE,
        stderr=subprocess.STDOUT,
    )

    assert out is not None
    context.add_cleanup(out.terminate)

    process_ccx_notification_writer_output(context, out, 2)


def check_help_from_ccx_notification_writer(context):
    """Check if help is displayed by CCX Notification Writer."""
    expected_output = """Clowder is not enabled, skipping init...
Usage of ccx-notification-writer:
  -authors
        show authors
  -check-kafka
        check connection to Kafka
  -db-cleanup
        perform database cleanup
  -db-drop-tables
        drop all tables from database
  -db-init
        perform database initialization
  -db-init-migration
        initialize migration
  -max-age string
        max age for displaying/cleaning old records
  -migrate string
        set database version
  -migration-info
        prints migration info
  -new-reports-cleanup
        perform new reports clean up
  -old-reports-cleanup
        perform old reports clean up
  -print-new-reports-for-cleanup
        print new reports to be cleaned up
  -print-old-reports-for-cleanup
        print old reports to be cleaned up
  -show-configuration
        show configuration
  -version
        show version"""

    assert context.stdout is not None
    stdout = context.stdout.decode("utf-8").replace("\t", "    ")

    # preliminary checks
    assert stdout is not None, "stdout object should exist"
    assert isinstance(stdout, str), "wrong type of stdout object"

    # don't mess with silly tabs

    updated_output = stdout.replace("\t", " ").strip()
    # check the output
    assert updated_output == expected_output.strip(), "{} != {}".format(
        stdout, expected_output
    )


def check_version_from_ccx_notification_writer(context):
    """Check if version info is displayed by CCX Notification Writer."""
    # preliminary checks
    assert context.output is not None
    assert type(context.output) is list, "wrong type of output"

    # check the output
    assert (
        "CCX Notification Writer version 1.0" in context.output
    ), "Caught output: {}".format(context.output)


def check_authors_info_from_ccx_notification_writer(context):
    """Check if information about authors is displayed by CCX Notification Writer."""
    # preliminary checks
    assert context.output is not None
    assert type(context.output) is list, "wrong type of output"

    # check the output
    assert (
        "Pavel Tisnovsky, Red Hat Inc." in context.output
    ), "Caught output: {}".format(context.output)


@then(u"the process should exit with status code set to {expected_code:d}")
def check_status_code(context, expected_code):
    """Check the status code of the last started process."""
    # check the return code of a process
    assert (
        context.returncode == expected_code
    ), "Return code is {}, but {} is expected".format(context.returncode, expected_code)


@given(u"CCX Notification database is empty")
def notification_writer_db_empty(context):
    """Ensure that the CCX Notification database is empty, but with all tables."""
    # first step - drop all tables, together with theirs content
    # TODO: --drop-tables does not delete the tables created by migrations, so --migrate fails

    from steps.notification_database import ensure_database_emptiness

    ensure_database_emptiness(context)

    # second step - initialize migration info
    out = subprocess.Popen(
        ["ccx-notification-writer", "--db-init-migration"],
        stdout=subprocess.PIPE,
        stderr=subprocess.STDOUT,
    )

    # check the Popen state
    assert out is not None
    out.communicate()

    # wait to finish the process - needed there (transactions)
    out.wait()

    # third step - create tables, create indexes, fill in table of keys
    out = subprocess.Popen(
        ["ccx-notification-writer", "--db-init"],
        stdout=subprocess.PIPE,
        stderr=subprocess.STDOUT,
    )

    # check the Popen state
    assert out is not None
    out.communicate()

    # wait to finish the process - needed there (transactions)
    out.wait()
