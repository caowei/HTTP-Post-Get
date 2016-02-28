####################################################################
# Some useful functions.
# Encryption / Decryptions
####################################################################

# Global Variables
#-----------------------------------------------------------------------------------------------------------

#Encrypt String to the File
Function encryptStringToFile($encryptFile) {

    $secString = Get-Content $encryptFile | ConvertTo-SecureString
    $BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($secString)
    $decryptedStr = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)
    return $decryptedStr
}

#This method must be use pair with encryptStringToFile. String encrypted in another PC can't be decrypted use this PC
Function decryptToString($encryptFile) {

    $secString = Get-Content $encryptFile | ConvertTo-SecureString
    $BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($secString)
    $decryptedStr = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)
    return $decryptedStr
}

$EMAIL_TO    = @("caowei@gmail.com","test@gmail.com")
$SMTP_SERVER = "TOSET";
$EMAIL_FROM  = "TOSET";
Function alertMail ($body, $subject,$priority) {

    try {
        if (-not $subject){
	        $subject = "Default Subject"
        }
	    
        if ($priority -eq "high" -or $priority -eq "High"){
            Write-Host "send-MailMessage -SmtpServer $SMTP_SERVER -To $EMAIL_TO -From $EMAIL_FROM -Subject $subject -Body $body -BodyAsHtml -Priority high"
            send-MailMessage -SmtpServer $SMTP_SERVER -To $EMAIL_TO -From $EMAIL_FROM -Subject $subject -Body $body -BodyAsHtml -Priority high
        
        } else {
            Write-Host "send-MailMessage -SmtpServer $SMTP_SERVER -To $EMAIL_TO -From $EMAIL_FROM -Subject $subject -Body $body -BodyAsHtml -Priority Normal"
            send-MailMessage -SmtpServer $SMTP_SERVER -To $EMAIL_TO -From $EMAIL_FROM -Subject $subject -Body $body -BodyAsHtml -Priority Normal
        }

        Write-Host "Send email successfully"
        
    } catch {
        Write-Host $_.Exception.GetType().FullName, $_.Exception.Message
    }
}

