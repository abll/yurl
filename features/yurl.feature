Feature: Yurl

    Scenario: Dump Yaml File
        When I run  'exe/yurl'
        Then the output should contain "Test Nested Secrets"