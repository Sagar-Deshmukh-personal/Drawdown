To run the following project on your local machine please follow below instructions:

1. Git Clone -https://github.com/Sagar-Deshmukh-personal/Drawdown
   For understanding purpose I have kept target folder consisting of reports but in ideal use case when committing code 'target/' folder is excluded

2. Use following command in terminal:
    - mvn clean install
    - mvn test "-Dkarate.options=--tags @sanity"
3. Test reports will be generated inside folder '/target' open the same in browser to review
    - Cucumber report - /target/cucumber-html-reports/overview-features.html
    - Basic karate report - /target/karate-reports/karate-summary.html
4. The report will demonstarte table 'Scenarios' - Pass/Fail v/s the Feature and it will aslo display the same for 'No. of steps for those scenarios'
   Click on the feature file to read detailed steps and execution output

If any doubts please contact me on below details:
    - Owner: Sagar-Deshmukh
    - Email: sagar.deshmukh@mintifi.com
Below is the karate framework and project details:

# https://github.com/Sagar-Deshmukh-personal/Drawdown
