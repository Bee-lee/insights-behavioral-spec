Feature: Sorting on cluster view page with recommendations behaviour on Hybrid Cloud Console


  Scenario: Default sort order in recommendations table on cluster view page on Hybrid Cloud Console with five recommendations and one cluster
    Given user USER1 is part of account (organization) ACCOUNT1
      And account (organization) ACCOUNT1 owns 4 clusters
          | Cluster name                         |
          | 00000000-0000-0000-0000-000000000000 |
      And 4 issues are detected for cluster 00000000-0000-0000-0000-000000000000
          | Title    | Modified    | Total risk |
          | Bug12345 | 10 days ago | Critical   |
          | Abc12345 | 10 days ago | Important  |
          | Xyz12345 | 10 days ago | Moderate   |
          | Uvw12345 | 10 days ago | Low        |
      And 1 another issue without cluster hit exists
          | Title    | Modified    | Total risk |
          | Nohit    | 10 days ago | Critical   |
      And the user USER1 is already logged in into Hybrid Cloud Console
     When user looks at Hybrid Cloud Console main page
     Then menu on the left side should be displayed
      And the left menu might contain these top level items
          | Left menu item           | Required for this test |
          | Overview                 | no                     |
          | Releases                 | no                     |
          | Downloads                | no                     |
          | Advisor                  | yes                    |
          | Subscriptions            | no                     |
          | Cost Management          | no                     |
          | Cluster Manager Feedback | no                     |
          | Red Hat Marketplace      | no                     |
          | Documentation            | no                     |
     When user expand "Advisor" top level item
     Then the menu should be expanded under "Advisor" top level item
      And following new items should be displayed in the sub-menu on the left side
          | Expanded menu item  | Required for this test |
          | Clusters            | no                     |
          | Recommendations     | yes                    |
     When user select "Recommendations" menu item from this sub-menu
     Then an "Advisor recommendations" page should be displayed right of the left menu bar
      And that table should contain following four rows in that order
          | Name        | Modified    | Total risk | Clusters |
          | Bug12345    | 10 days ago | Critical   | 1        |
          | Abc12345    | 10 days ago | Important  | 1        |
          | Xyz12345    | 10 days ago | Moderate   | 1        |
          | Uvw12345    | 10 days ago | Low        | 1        |
     When user clicks on an "Bug12345" link
     Then new page with additional information about selected recommendation should be displayed
      And the following values needs to be displayed
          | Value type  | Content             | Displayed as              | Optional |
          | Description | Textual description | Text                      | no       |
          | KB article  | Link to KB article  | Link                      | yes      |
          | Total risk  | Important           | Widget (icon+label)       | no       |
          | Likelihood  | High                | Widget (thermometer-like) | no       |
          | Impact      | High                | Widget (thermometer-like) | no       |
      And "Affected clusters" table needs to be displayed below additional info
          | Name                                 | Clickable (link) |
          | 00000000-0000-0000-0000-000000000000 | yes              |
      When user clicks on cluster name (00000000-0000-0000-0000-000000000000)
      Then a new page needs to be displayd
       And that page should contain following controls and widgets
          | Control/widget  | Content                                                               |
          | Page title      | Advisor clusters -> 00000000-0000-0000-0000-000000000000              |
          | Cluster name    | 00000000-0000-0000-0000-000000000000                                  |
          | Cluster UUID    | 00000000-0000-0000-0000-000000000000                                  |
          | Expand/collapse | Icon > or v controlling expansion and collapse of all recommendations |
          | Filter widget   | Filter selection, addional widget, "Collapse all" button              |
          | Active filter   | Status "Enabled" + Reset filters link                                 |
          | Recommendations | Table containing list of recommendations                              |
     When user look at "Recommendations" table
     Then table with several columns should be displayed with sorting setting
          | Column name | Sort | Highlighted |
          | Descriptiom | ↕    | no          |
          | Modified    | ↕    | no          |
          | Total risk  | ↕    | no          |
      And the table should contain following rows in any order
          | Index | Description | Modified    | Total risk | (Expanded) |
          | ?     | Bug12345    | 10 days ago | Critical   | yes        |
          | ?     | Abc12345    | 10 days ago | Important  | no         |
          | ?     | Xyz12345    | 10 days ago | Moderate   | no         |
          | ?     | Uvw12345    | 10 days ago | Low        | no         |


  Scenario: Sorting by description in recommendations table on cluster view page on Hybrid Cloud Console with five recommendations and one cluster
    Given user USER1 is part of account (organization) ACCOUNT1
      And account (organization) ACCOUNT1 owns 4 clusters
          | Cluster name                         |
          | 00000000-0000-0000-0000-000000000000 |
      And 4 issues are detected for cluster 00000000-0000-0000-0000-000000000000
          | Title    | Modified    | Total risk |
          | Bug12345 | 10 days ago | Critical   |
          | Abc12345 | 10 days ago | Important  |
          | Xyz12345 | 10 days ago | Moderate   |
          | Uvw12345 | 10 days ago | Low        |
      And 1 another issue without cluster hit exists
          | Title    | Modified    | Total risk |
          | Nohit    | 10 days ago | Critical   |
      And the user USER1 is already logged in into Hybrid Cloud Console
     When user looks at Hybrid Cloud Console main page
     Then menu on the left side should be displayed
      And the left menu might contain these top level items
          | Left menu item           | Required for this test |
          | Overview                 | no                     |
          | Releases                 | no                     |
          | Downloads                | no                     |
          | Advisor                  | yes                    |
          | Subscriptions            | no                     |
          | Cost Management          | no                     |
          | Cluster Manager Feedback | no                     |
          | Red Hat Marketplace      | no                     |
          | Documentation            | no                     |
     When user expand "Advisor" top level item
     Then the menu should be expanded under "Advisor" top level item
      And following new items should be displayed in the sub-menu on the left side
          | Expanded menu item  | Required for this test |
          | Clusters            | no                     |
          | Recommendations     | yes                    |
     When user select "Recommendations" menu item from this sub-menu
     Then an "Advisor recommendations" page should be displayed right of the left menu bar
      And that table should contain following four rows in that order
          | Name        | Modified    | Total risk | Clusters |
          | Bug12345    | 10 days ago | Critical   | 1        |
          | Abc12345    | 10 days ago | Important  | 1        |
          | Xyz12345    | 10 days ago | Moderate   | 1        |
          | Uvw12345    | 10 days ago | Low        | 1        |
     When user clicks on an "Bug12345" link
     Then new page with additional information about selected recommendation should be displayed
      And the following values needs to be displayed
          | Value type  | Content             | Displayed as              | Optional |
          | Description | Textual description | Text                      | no       |
          | KB article  | Link to KB article  | Link                      | yes      |
          | Total risk  | Important           | Widget (icon+label)       | no       |
          | Likelihood  | High                | Widget (thermometer-like) | no       |
          | Impact      | High                | Widget (thermometer-like) | no       |
      And "Affected clusters" table needs to be displayed below additional info
          | Name                                 | Clickable (link) |
          | 00000000-0000-0000-0000-000000000000 | yes              |
      When user clicks on cluster name (00000000-0000-0000-0000-000000000000)
      Then a new page needs to be displayd
       And that page should contain following controls and widgets
          | Control/widget  | Content                                                               |
          | Page title      | Advisor clusters -> 00000000-0000-0000-0000-000000000000              |
          | Cluster name    | 00000000-0000-0000-0000-000000000000                                  |
          | Cluster UUID    | 00000000-0000-0000-0000-000000000000                                  |
          | Expand/collapse | Icon > or v controlling expansion and collapse of all recommendations |
          | Filter widget   | Filter selection, addional widget, "Collapse all" button              |
          | Active filter   | Status "Enabled" + Reset filters link                                 |
          | Recommendations | Table containing list of recommendations                              |
     When user look at "Recommendations" table
     Then table with several columns should be displayed with sorting setting
          | Column name | Sort | Highlighted |
          | Description | ↕    | no          |
          | Modified    | ↕    | no          |
          | Total risk  | ↕    | no          |
      And the table should contain following rows in any order
          | Index | Description | Modified    | Total risk | (Expanded) |
          | ?     | Bug12345    | 10 days ago | Critical   | yes        |
          | ?     | Abc12345    | 10 days ago | Important  | no         |
          | ?     | Xyz12345    | 10 days ago | Moderate   | no         |
          | ?     | Uvw12345    | 10 days ago | Low        | no         |
     When user clicks on ↕ symbol in "Description" column title
     Then table with recommendations should be rearranged
          | Column name | Sort | Highlighted |
          | Description | ↑    | yes         |
          | Modified    | ↕    | no          |
          | Total risk  | ↕    | no          |
      And the table should contain following rows in that order
          | Index | Description | Modified    | Total risk | (Expanded) |
          | 1     | Abc12345    | 10 days ago | Important  | no         |
          | 2     | Bug12345    | 10 days ago | Critical   | yes        |
          | 3     | Uvw12345    | 10 days ago | Low        | no         |
          | 4     | Xyz12345    | 10 days ago | Moderate   | no         |
     When user clicks on ↑ symbol in "Description" column title
     Then table with recommendations should be rearranged
          | Column name | Sort | Highlighted |
          | Description | ↓    | yes         |
          | Modified    | ↕    | no          |
          | Total risk  | ↕    | no          |
      And the table should contain following rows in that order
          | Index | Description | Modified    | Total risk | (Expanded) |
          | 1     | Xyz12345    | 10 days ago | Moderate   | no         |
          | 2     | Uvw12345    | 10 days ago | Low        | no         |
          | 3     | Bug12345    | 10 days ago | Critical   | yes        |
          | 4     | Abc12345    | 10 days ago | Important  | no         |


  Scenario: Sorting by added at in recommendations table on cluster view page on Hybrid Cloud Console with five recommendations and one cluster
    Given user USER1 is part of account (organization) ACCOUNT1
      And account (organization) ACCOUNT1 owns 4 clusters
          | Cluster name                         |
          | 00000000-0000-0000-0000-000000000000 |
      And 4 issues are detected for cluster 00000000-0000-0000-0000-000000000000
          | Title    | Modified    | Total risk |
          | Bug12345 | 10 days ago | Critical   |
          | Abc12345 | 20 days ago | Important  |
          | Xyz12345 | 30 days ago | Moderate   |
          | Uvw12345 | 40 days ago | Low        |
      And 1 another issue without cluster hit exists
          | Title    | Modified    | Total risk |
          | Nohit    | 10 days ago | Critical   |
      And the user USER1 is already logged in into Hybrid Cloud Console
     When user looks at Hybrid Cloud Console main page
     Then menu on the left side should be displayed
      And the left menu might contain these top level items
          | Left menu item           | Required for this test |
          | Overview                 | no                     |
          | Releases                 | no                     |
          | Downloads                | no                     |
          | Advisor                  | yes                    |
          | Subscriptions            | no                     |
          | Cost Management          | no                     |
          | Cluster Manager Feedback | no                     |
          | Red Hat Marketplace      | no                     |
          | Documentation            | no                     |
     When user expand "Advisor" top level item
     Then the menu should be expanded under "Advisor" top level item
      And following new items should be displayed in the sub-menu on the left side
          | Expanded menu item  | Required for this test |
          | Clusters            | no                     |
          | Recommendations     | yes                    |
     When user select "Recommendations" menu item from this sub-menu
     Then an "Advisor recommendations" page should be displayed right of the left menu bar
      And that table should contain following four rows in that order
          | Name        | Modified    | Total risk | Clusters |
          | Bug12345    | 10 days ago | Critical   | 1        |
          | Abc12345    | 20 days ago | Important  | 1        |
          | Xyz12345    | 30 days ago | Moderate   | 1        |
          | Uvw12345    | 40 days ago | Low        | 1        |
     When user clicks on an "Bug12345" link
     Then new page with additional information about selected recommendation should be displayed
      And the following values needs to be displayed
          | Value type  | Content             | Displayed as              | Optional |
          | Description | Textual description | Text                      | no       |
          | KB article  | Link to KB article  | Link                      | yes      |
          | Total risk  | Important           | Widget (icon+label)       | no       |
          | Likelihood  | High                | Widget (thermometer-like) | no       |
          | Impact      | High                | Widget (thermometer-like) | no       |
      And "Affected clusters" table needs to be displayed below additional info
          | Name                                 | Clickable (link) |
          | 00000000-0000-0000-0000-000000000000 | yes              |
      When user clicks on cluster name (00000000-0000-0000-0000-000000000000)
      Then a new page needs to be displayd
       And that page should contain following controls and widgets
          | Control/widget  | Content                                                               |
          | Page title      | Advisor clusters -> 00000000-0000-0000-0000-000000000000              |
          | Cluster name    | 00000000-0000-0000-0000-000000000000                                  |
          | Cluster UUID    | 00000000-0000-0000-0000-000000000000                                  |
          | Expand/collapse | Icon > or v controlling expansion and collapse of all recommendations |
          | Filter widget   | Filter selection, addional widget, "Collapse all" button              |
          | Active filter   | Status "Enabled" + Reset filters link                                 |
          | Recommendations | Table containing list of recommendations                              |
     When user look at "Recommendations" table
     Then table with several columns should be displayed with sorting setting
          | Column name | Sort | Highlighted |
          | Description | ↕    | no          |
          | Modified    | ↕    | no          |
          | Total risk  | ↕    | no          |
      And the table should contain following rows in any order
          | Index | Description | Modified    | Total risk | (Expanded) |
          | ?     | Bug12345    | 10 days ago | Critical   | yes        |
          | ?     | Abc12345    | 20 days ago | Important  | no         |
          | ?     | Xyz12345    | 30 days ago | Moderate   | no         |
          | ?     | Uvw12345    | 40 days ago | Low        | no         |
     When user clicks on ↕ symbol in "Modified" column title
     Then table with recommendations should be rearranged
          | Column name | Sort | Highlighted |
          | Description | ↕    | no          |
          | Modified    | ↑    | yes         |
          | Total risk  | ↕    | no          |
      And the table should contain following rows in that order
          | Index | Description | Modified    | Total risk | (Expanded) |
          | 1     | Uvw12345    | 40 days ago | Low        | no         |
          | 2     | Xyz12345    | 30 days ago | Moderate   | no         |
          | 3     | Abc12345    | 20 days ago | Important  | no         |
          | 4     | Bug12345    | 10 days ago | Critical   | yes        |
     When user clicks on ↑ symbol in "Modified" column title
     Then table with recommendations should be rearranged
          | Column name | Sort | Highlighted |
          | Description | ↕    | yes         |
          | Modified    | ↓    | no          |
          | Total risk  | ↕    | no          |
      And the table should contain following rows in that order
          | Index | Description | Modified    | Total risk | (Expanded) |
          | 1     | Bug12345    | 10 days ago | Critical   | yes        |
          | 2     | Abc12345    | 20 days ago | Important  | no         |
          | 3     | Xyz12345    | 30 days ago | Moderate   | no         |
          | 4     | Uvw12345    | 40 days ago | Low        | no         |


  Scenario: Sorting by total risk at in recommendations table on cluster view page on Hybrid Cloud Console with five recommendations and one cluster
    Given user USER1 is part of account (organization) ACCOUNT1
      And account (organization) ACCOUNT1 owns 4 clusters
          | Cluster name                         |
          | 00000000-0000-0000-0000-000000000000 |
      And 4 issues are detected for cluster 00000000-0000-0000-0000-000000000000
          | Title    | Modified    | Total risk |
          | Bug12345 | 10 days ago | Critical   |
          | Abc12345 | 20 days ago | Important  |
          | Xyz12345 | 30 days ago | Moderate   |
          | Uvw12345 | 40 days ago | Low        |
      And 1 another issue without cluster hit exists
          | Title    | Modified    | Total risk |
          | Nohit    | 10 days ago | Critical   |
      And the user USER1 is already logged in into Hybrid Cloud Console
     When user looks at Hybrid Cloud Console main page
     Then menu on the left side should be displayed
      And the left menu might contain these top level items
          | Left menu item           | Required for this test |
          | Overview                 | no                     |
          | Releases                 | no                     |
          | Downloads                | no                     |
          | Advisor                  | yes                    |
          | Subscriptions            | no                     |
          | Cost Management          | no                     |
          | Cluster Manager Feedback | no                     |
          | Red Hat Marketplace      | no                     |
          | Documentation            | no                     |
     When user expand "Advisor" top level item
     Then the menu should be expanded under "Advisor" top level item
      And following new items should be displayed in the sub-menu on the left side
          | Expanded menu item  | Required for this test |
          | Clusters            | no                     |
          | Recommendations     | yes                    |
     When user select "Recommendations" menu item from this sub-menu
     Then an "Advisor recommendations" page should be displayed right of the left menu bar
      And that table should contain following four rows in that order
          | Name        | Modified    | Total risk | Clusters |
          | Bug12345    | 10 days ago | Critical   | 1        |
          | Abc12345    | 20 days ago | Important  | 1        |
          | Xyz12345    | 30 days ago | Moderate   | 1        |
          | Uvw12345    | 40 days ago | Low        | 1        |
     When user clicks on an "Bug12345" link
     Then new page with additional information about selected recommendation should be displayed
      And the following values needs to be displayed
          | Value type  | Content             | Displayed as              | Optional |
          | Description | Textual description | Text                      | no       |
          | KB article  | Link to KB article  | Link                      | yes      |
          | Total risk  | Important           | Widget (icon+label)       | no       |
          | Likelihood  | High                | Widget (thermometer-like) | no       |
          | Impact      | High                | Widget (thermometer-like) | no       |
      And "Affected clusters" table needs to be displayed below additional info
          | Name                                 | Clickable (link) |
          | 00000000-0000-0000-0000-000000000000 | yes              |
      When user clicks on cluster name (00000000-0000-0000-0000-000000000000)
      Then a new page needs to be displayd
       And that page should contain following controls and widgets
          | Control/widget  | Content                                                               |
          | Page title      | Advisor clusters -> 00000000-0000-0000-0000-000000000000              |
          | Cluster name    | 00000000-0000-0000-0000-000000000000                                  |
          | Cluster UUID    | 00000000-0000-0000-0000-000000000000                                  |
          | Expand/collapse | Icon > or v controlling expansion and collapse of all recommendations |
          | Filter widget   | Filter selection, addional widget, "Collapse all" button              |
          | Active filter   | Status "Enabled" + Reset filters link                                 |
          | Recommendations | Table containing list of recommendations                              |
     When user look at "Recommendations" table
     Then table with several columns should be displayed with sorting setting
          | Column name | Sort | Highlighted |
          | Description | ↕    | no          |
          | Modified    | ↕    | no          |
          | Total risk  | ↕    | no          |
      And the table should contain following rows in any order
          | Index | Description | Modified    | Total risk | (Expanded) |
          | ?     | Bug12345    | 10 days ago | Critical   | yes        |
          | ?     | Abc12345    | 20 days ago | Important  | no         |
          | ?     | Xyz12345    | 30 days ago | Moderate   | no         |
          | ?     | Uvw12345    | 40 days ago | Low        | no         |
     When user clicks on ↕ symbol in "Total risk" column title
     Then table with recommendations should be rearranged
          | Column name | Sort | Highlighted |
          | Description | ↕    | no          |
          | Modified    | ↕    | no          |
          | Total risk  | ↑    | yes         |
      And the table should contain following rows in that order
          | Index | Description | Modified    | Total risk | (Expanded) |
          | 1     | Uvw12345    | 40 days ago | Low        | no         |
          | 2     | Xyz12345    | 30 days ago | Moderate   | no         |
          | 3     | Abc12345    | 20 days ago | Important  | no         |
          | 4     | Bug12345    | 10 days ago | Critical   | yes        |
     When user clicks on ↑ symbol in "Total risk" column title
     Then table with recommendations should be rearranged
          | Column name | Sort | Highlighted |
          | Description | ↕    | no          |
          | Modified    | ↕    | no          |
          | Total risk  | ↓    | yes         |
      And the table should contain following rows in that order
          | Index | Description | Modified    | Total risk | (Expanded) |
          | 1     | Bug12345    | 10 days ago | Critical   | yes        |
          | 2     | Abc12345    | 20 days ago | Important  | no         |
          | 3     | Xyz12345    | 30 days ago | Moderate   | no         |
          | 4     | Uvw12345    | 40 days ago | Low        | no         |
