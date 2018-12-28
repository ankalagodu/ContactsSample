# ContactsSample
Used to make post request to API to get the contact details and display in screen using tableview.

Following steps required to Run ContactsSample
1. Download ContactsSample Zip file and unarchive it.
2. Goto terminal and run below command
   cd pathTo_ContactsSample_directory
3. If you dont have CocoaPods installed run below command
   [sudo] gem install cocoapods
4. Run pod install --repo-update
5. If Cocoapods installation complete run below command
   pod install
6. Open ContactsSample.xcworkspace and Run your project:
   Command + R / Product Menu -> Run
7. When Application Runs for first time Entry form will appear, then user has to enter valid Email ID. On submit action checks for email
   id valid or not. if valid only calling post request to service API.
8. On success of API call get the "items" array from JSON response and presenting the Contact details screen to display contact
   information which we got from the JSON response.
   

   
