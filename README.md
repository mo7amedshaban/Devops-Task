# Task 1 

1. How your script handles arguments and options:

I used getopts to handle flags like -n and -v. The script processes the flags, checks for at least two arguments (search string and filename), and ensures the file exists. If anything is missing, it shows an error.

2. How would the structure change to support regex or -i/-c/-l options?

To support options like -e for regex or -c for count, I would expand getopts to include these flags. I'd modify the grep command to handle these options and adjust the output accordingly, either showing a count or file names.

3. What part of the script was hardest to implement and why?

The hardest part was handling combined options like -vn or -nv. I had to ensure the script could process them in any order and show the correct output or error when needed.



# Task 2 - Troubleshooting Report

1. What I Did

When I tried accessing internal.example.com, it wasn’t resolving.\
I ran:

ping internal.example.com

and got this error:\
ping: cannot resolve internal.example.com: Unknown host

To check if it was a DNS issue, I tested using Google's DNS:

dig @8.8.8.8 internal.example.com

The result showed NXDOMAIN, confirming that DNS couldn't find the domain.

To quickly fix the name resolution for testing, I edited my /etc/hosts file:

sudo nano /etc/hosts

and added this line:

192.168.1.100 internal.example.com

After that, I ran ping again and it successfully reached the server IP.

2. Checking the Service

After fixing DNS locally, I checked if the service on port 80 was reachable.\
I used netcat (nc) to test:

nc -zv internal.example.com 80

It failed with the message:\
nc: connectx to internal.example.com port 80 (tcp) failed: Host is down

This meant the server was reachable (ICMP worked), but the web service (HTTP) was not available.

3. Possible Causes

Here are the potential reasons why the service might still be unreachable:

- The web server (like Apache or Nginx) is not running.
- The firewall is blocking port 80.
- The service crashed or was misconfigured.
- Port 80 is closed or the server isn’t listening on it.

4. How I Would Confirm and Fix

| Problem                   | How to Confirm                                     | How to Fix                   |          |                                        |
| ------------------------- | -------------------------------------------------- | ---------------------------- | -------- | -------------------------------------- |
| Web server not running    | systemctl status apache2 or systemctl status nginx | sudo systemctl start apache2 |          |                                        |
| Firewall blocking port 80 | sudo ufw status                                    | sudo ufw allow 80/tcp        |          |                                        |
| Service crash or error    | journalctl -u apache2 or journalctl -u nginx       | Restart the service          |          |                                        |
| Port 80 not listening     | netstat -tulnp                                     | grep :80 or ss -tulnp        | grep :80 | Fix server config to listen on port 80 |

Note: Since I am on macOS, I couldn't directly check services like systemctl. Normally, these checks would be done from the server itself.

5. Bonus Actions

- I manually edited /etc/hosts to bypass DNS temporarily and confirm the server was reachable.
- To make DNS settings persistent (on Linux), tools like systemd-resolved or NetworkManager are used.

Screenshots I Captured:

- DNS failure results
- /etc/hosts editing
- Successful ping response
- Failed nc connection on port 80

Final Thoughts

This troubleshooting task helped me focus on separating DNS issues from actual network and service problems.\
I made sure to fix name resolution first before moving to check if the service was actually running.
