import json
import requests

url = "http://foo2:13130/api/v1/repos/migrate"

clone_addr = "https://github.com/kelseyhightower/nocode"
repo_name = "nocode"

token='7647651a10e406463f45267ab53699b2fbecXdrV'
github_token="ghp_N42BU19cfjVGgp1ycccloi6ZsWb8c6AXp380"

def migrate_repo(clone_addr, repo_name, uid):
    print(clone_addr, repo_name)
    payload2={"clone_addr": clone_addr,"uid": uid,"repo_name": repo_name, "mirror": False, 
    "private": True, "description": "description " +repo_name, "auth_username": "foo9730", "auth_password": github_token}

    headers = {
        'Authorization': 'token '+token,
        'Content-Type': 'application/json',
        'Cookie': 'lang=en-US'
    }
    payload = json.dumps(payload2)
    response = requests.request("POST", url, headers=headers, data=payload)

    print(response.text)


def migrate_task():
    repo_name_list = ["nocode", "weeklog"]
    clone_addr_list = repo_name_list
    uid = 6
    for clone_addr, repo_name in zip(clone_addr_list, repo_name_list):
        clone_addr = "https://github.com/foo/%s" % repo_name
        migrate_repo(clone_addr, repo_name, uid)
