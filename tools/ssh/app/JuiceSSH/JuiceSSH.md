# JuiceSSH


If your key file is still not being found by Smart Search, you can see the exact method which is used to check each file here.
It reveals that the criteria for being recognised as a valid key file are:
File size < 8kb
First 37 chars contain one of:
"-----BEGIN RSA PRIVATE KEY-----"
"-----BEGIN DSA PRIVATE KEY-----"
"-----BEGIN PRIVATE KEY-----"
"-----BEGIN ENCRYPTED PRIVATE KEY-----"