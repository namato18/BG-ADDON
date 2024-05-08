import os
import time
import requests
import re
import csv

# Get the directory of the current script
script_dir = os.path.dirname(os.path.abspath(__file__))

# Construct the full path to the "Account" directory
account_dir = os.path.join(script_dir,'..','..', '..','..', '..','..', 'WTF', 'Account')

# List all directories within the "Account" directory
account_subdirs = [d for d in os.listdir(account_dir) if os.path.isdir(os.path.join(account_dir, d))]

# Select the directory that isn't "SavedVariables"
selected_dir = next(d for d in account_subdirs if d != "SavedVariables")

# Construct the full path to the Lua file within the selected directory
lua_file_path = os.path.join(account_dir, selected_dir, 'SavedVariables', 'HelloWorld.lua')


api_url = "http://165.232.134.236:8000/WoWAPI"
print('hello')

def process_lua_file(file_path):
    # Open the Lua file with UTF-8 encoding
    with open(file_path, 'r', encoding='utf-8') as f:
        lua_content = f.read()

    # Extract data from Lua content using regular expressions
    pattern = re.compile(r'"(.*?)"')  # Define the pattern to extract values in quotes
    matches = re.findall(pattern, lua_content)  # Find all matches of the pattern

    # Convert extracted data to CSV format
    csv_data = [match.split(',') for match in matches]  # Split each match by comma to get individual values

    return csv_data


# print('should have triggered')


# Function to read Lua file, convert to CSV, and push to API
# def process_lua_file_and_push(api_url, lua_file_path):
#     # Open the Lua file
#     with open(lua_file_path, 'r') as f:
#         lua_content = f.read()

#     # Extract data from Lua content
#     pattern = re.compile(r'"(.*?)"')  # Define the pattern to extract values in quotes
#     matches = re.findall(pattern, lua_content)  # Find all matches of the pattern

#     # Write extracted data to CSV
#     csv_data = []
#     for match in matches:
#         data = match.split(',')  # Split each match by comma to get individual values
#         csv_data.append(data)


def make_api_call(csv_data):
    # Define the URL of your API endpoint
    api_url = "http://165.232.134.236:8000/WoWAPI"
    
    payload = {"csv_data": csv_data}

    # Make an API call with POST method
    response = requests.post(api_url, json=payload)
    if response.status_code == 200:
        print("API call successful")
    else:
        print("API call failed")

        

def watch_file_changes(filename):
    # Get the initial modification time of the file
    last_modified = os.path.getmtime(filename)

    # Watch for changes in the file
    while True:
        # Check the current modification time of the file
        current_modified = os.path.getmtime(filename)

        # If the file has been modified since the last check, make the API call
        if current_modified != last_modified:
            print("File has changed. Making API call...")
            x = process_lua_file(lua_file_path)
            make_api_call(x)
            last_modified = current_modified

        # Wait for a short interval before checking again
        time.sleep(1)

if __name__ == "__main__":
    import os
    filename = "E:/World of Warcraft/_retail_/WTF/Account/AMATMIK/SavedVariables/HelloWorld.lua"
    watch_file_changes(filename)
