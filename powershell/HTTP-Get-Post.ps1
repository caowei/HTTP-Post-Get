####################################################################
# Sample scripts to do web page login
#
####################################################################

#Use Http Get to check html page availability
Function simpleHttpGet ($url,$timeout) {
    
    try {
        
        #Ignore SSL certificate validation error if any
        [System.Net.ServicePointManager]::ServerCertificateValidationCallback = {$true}

        $req = [system.Net.WebRequest]::Create($url)
        $req.Timeout = $timeout
        $res = $req.GetResponse()

    } catch {
        Write-Host $_.Exception.GetType().FullName, $_.Exception.Message
        $res = $_.Exception.Response
    }
    $resStatus = [int]$res.StatusCode 
    
    try {
        $res.Close()
    } catch {
        Write-Host $_.Exception.GetType().FullName, $_.Exception.Message
    }
    
    return $resStatus
}

#Example to login to a web page by submit data to form
Function simpleHttpPost($loginUrl,$formData) {
    $htmlResult = ""
    try {
        [System.Net.ServicePointManager]::ServerCertificateValidationCallback = {$true}
        #$formData = "username=$userName&password=$password&login-form-type=pwd"
        $body = [byte[]][char[]]$formData
        $request = [System.Net.WebRequest]::Create($loginUrl)
        #timeout 60 second
        $request.Timeout = 60000
        $request.Method = 'POST';
        $request.ContentType = "application/x-www-form-urlencoded"
        $stream = $request.GetRequestStream()
        $stream.Write($body, 0, $body.Length)
        $response = $request.GetResponse()
        $reqstream = $response.GetResponseStream()
        $sr = new-object System.IO.StreamReader $reqstream
        $htmlResult = $sr.ReadToEnd()
        write-host $htmlResult
        
    } catch {
        $htmlResult = "Error occurs while submit data to $loginUrl"
        Write-Host $_.Exception.GetType().FullName, $_.Exception.Message
    }

    try {
        $response.Close()
         write-host "Connection closed $loginUrl"
    } catch {
    }

    return $htmlResult
}

write-host "This is test scripts"
$httpStatus = (simpleHttpGet "https://www.google.com" 5000)
write-host $httpStatus

$httpResult = (simpleHttpPost "http://www.w3schools.com/html/demo_form_exercise.php" "name=loginTest")
write-host $httpResult