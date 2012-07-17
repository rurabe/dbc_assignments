require 'mechanize'
require 'launchy'

# username = "RUrabe5a4ff2"
# password = "Mrg00dbytes"
# url = "https://app.applyyourself.com/AYApplicantLogin/ApplicantConnectLogin.asp?id=mit-mba"
# user_agent = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_4) AppleWebKit/536.11 (KHTML, like Gecko) Chrome/20.0.1132.57 Safari/536.11'
# 
# agent = Mechanize.new
# 
# agent.user_agent = user_agent
# 
# login_page = agent.get(url)
# 
# signin = login_page.form('frmApplicantLogin')
# signin.UserID = username
# signin.Password = password
# 
# Launchy.open(agent.submit(signin).uri)



username = "RUrabe5a4ff2"
password = "Mrg00dbytes"
url = "https://app.applyyourself.com/AYApplicantLogin/ApplicantConnectLogin.asp?id=mit-mba"
user_agent = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_4) AppleWebKit/536.11 (KHTML, like Gecko) Chrome/20.0.1132.57 Safari/536.11'

agent = Mechanize.new

agent.user_agent = user_agent

login_page = agent.get(url)

signin = login_page.form('frmApplicantLogin')
signin.UserID = username
signin.Password = password

Launchy.open(agent.submit(signin).uri)
