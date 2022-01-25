Feature: Gmail UI test

    Background: preparation
        * def waitForElementDisappear = function(element){ waitForResultCount(element, 0); delay(100); }
        * configure driver = { type: 'chrome', executable: '"C:\\Program Files\\Google\\Chrome\\Application\\chrome.exe"' }
        * def emailField = "//input[@name='identifier']"
        * def selectedUserDropDown = "//div[@role='link']"
        * def passwordField = "//input[@name='password']"
        * def nextButton = "//button[@type='button']//span[text()='Далее']"
        * def userIcon = "//div[@data-ogsr-up]//a[contains(@aria-label,'Аккаунт Google:')]"
        * def newEmailButton = "//div[@role='button'][text()='Написать']"
        * def emailVidget = "//div[@role='dialog']"
        * def emailVidgetTitle = emailVidget + "//h2//span"
        * def closeEmailVidgetButton = emailVidget + "//*[@aria-label='Сохранить и закрыть']"
        * def toField = emailVidget + "//textarea[@name='to']"
        * def enteredRecipients = emailVidget + "//span[@email]/div[1]"
        * def subjectField = emailVidget + "//input[@name='subjectbox']"
        * def emailContetntTextArea = emailVidget + "//div[@role='textbox']"
        * def draftButton = "//a[text()='Черновики']"
        * def emailSubject = function(numberOfEmail) { return `//div[@role='main']//table//tr[${numberOfEmail}]//td[@role='gridcell'][2]//span[@data-thread-id]`}
        
    Scenario: Simple email test

        Given def runDatetime = (function() { return (new Date()).toISOString() })()
        * def userEmail = "testuser4622@gmail.com"
        * def userPassword = "Testuser293"
        * def reciepient = "test@test.com"
        * def subject = "Test subject 2022-01-24T11:50:04.258Z" //"Test subject " + runDatetime
        * def emailText = "Email test text"
        * driver "https://gmail.com"
        When waitFor(emailField).input(userEmail)
        * click(nextButton)
        * waitFor(selectedUserDropDown)
        * input(passwordField, userPassword)
        * click(nextButton)
        Then waitForUrl("https://mail.google.com/mail/u/0/#inbox")
        * match attribute(userIcon, 'aria-label') contains userEmail
        When click(newEmailButton)
        * waitFor(emailVidget)
        * input(toField, reciepient)
        * input(subjectField, subject)
        * input(emailContetntTextArea, emailText)
        * waitForText(emailVidgetTitle, "Черновик сохранен")
        * mouse().move(closeEmailVidgetButton).click()
        Then waitForElementDisappear(emailVidget)
        When click(draftButton)
        * waitForUrl("https://mail.google.com/mail/u/0/#drafts")
        Then assert text(emailSubject(1)) == subject
        When click(emailSubject(1))
        Then waitFor(emailVidget)
        * print text(enteredRecipients)
        * print reciepient
        * print text(emailVidgetTitle)
        * print text(emailContetntTextArea)
        * print emailText
    
        * assert text(enteredRecipients) == reciepient
        * assert text(emailVidgetTitle) == subject
        * assert text(emailContetntTextArea) == emailText
        * delay(5000)
#     • Verify the draft content (addressee, subject and body – should be the same as in 3);
#     • Send the mail;
#     • Verify, that the mail disappeared from ‘Drafts’ folder;
#     • Verify, that the mail is in ‘Sent’ folder;
#     • Log off.