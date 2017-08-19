Feature: Yurl
    Scenario: Hello World
        When I run 'yurl hello'
        Then the output should contain "Hello World" 
    
    Scenario: Dump Yaml File
        When I run  'yurl dump "Tested Nested Secrets: foo"'
        Then the output should contain "Test Nested Secrets"