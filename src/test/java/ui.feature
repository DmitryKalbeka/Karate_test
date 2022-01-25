Feature: Gmail UI test

    Background: preparation
        * def waitForElementDisappear = function(element){ waitForResultCount(element, 0); delay(100); }
        * configure driver = { type: 'chrome', executable: '"C:\\Program Files\\Google\\Chrome\\Application\\chrome.exe"' }
        * def userIcon = "//div[@data-ogsr-up]//a[contains(@aria-label,'Аккаунт Google:')]"
        * def draftButton = "//a[text()='Черновики']"
        * def emailSubject = function(numberOfEmail) { return `//div[@role='main']//table//tr[${numberOfEmail}]//td[@role='gridcell'][2]//span[@data-thread-id]`}
        
    Scenario: Simple email test

        Given def runDatetime = (function() { return (new Date()).toISOString() })()
        * def userEmail = "testuser4622@gmail.com"
        * def userPassword = "Testuser293"
        * def reciepient = "test@test.com"
        * def subject = "Test subject " + runDatetime
        * def emailText = "Email test text"
        * driver "https://gmail.com"
        When call read('classpath:steps/login.steps.feature@logInAs') { email: #(userEmail), password: #(userPassword) }
        * match attribute(userIcon, 'aria-label') contains userEmail
        * call read('classpath:steps/email.steps.feature@createDraftEmail') { reciepient: #(reciepient), subject: #(subject), emailText: #(emailText) }
        * click(draftButton)
        * waitForUrl("https://mail.google.com/mail/u/0/#drafts")
        Then assert text(emailSubject(1)) == subject
        When click(emailSubject(1))
        Then call read('classpath:steps/email.steps.feature@verifyEmail') { reciepient: #(reciepient), subject: #(subject), emailText: #(emailText) }
#     • Verify the draft content (addressee, subject and body – should be the same as in 3);
#     • Send the mail;
#     • Verify, that the mail disappeared from ‘Drafts’ folder;
#     • Verify, that the mail is in ‘Sent’ folder;
#     • Log off.