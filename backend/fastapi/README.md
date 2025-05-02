
<p align="center"> Few lines describing your project.
    <br> 
</p>

## 📝 Table of Contents

- [Getting Started](#getting_started)
- [Prerequisites](#prerequisites)
- [Installing](#installing)
- [Running the application](#running)

## 🏁 Getting Started <a name = "getting_started"></a>

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites
<a name = "prerequisites"></a>
python 3.13

```

```

### Installing
<a name = "installing"></a>

A step by step series of examples that tell you how to get a development env running.



<table border="1">
  <tr>
    <th>Shell</th>
    <th>Command to activate virtual environment</th>
  </tr>
  <tr>
    <td>bash/zsh</td>
    <td>$ source&nbsp;&nbsp;&lt;<i>venv</i>&gt;/bin/activate</td>
  </tr>
  <tr>
    <td>cmd.exe</td>
    <td>C:\> &nbsp;&nbsp;&lt;<i>venv</i>&gt;\Scripts\activate.bat</td>
  </tr>
  <tr>
    <td>powershell</td>
    <td>PS C:\> &nbsp;&nbsp;&lt;<i>venv</i>&gt;\Scripts\Activate.ps1</td>
  </tr>
</table>

1. cd into fastapi directory
2. run <strong>python -m venv .venv</strong> to create 
3. use above instructions to activate virtual environment based on your shell and set this as your python version when running the application
4. cd into the app directory now
5. while inside app directory run <strong>pip install -r requirements.txt</strong> to install required modules

### Running the application
<a name = "running"></a>

<h4><i>Running with FastAPI CLI</i></h3>
<p><strong>Note:&nbsp;<i>You can't debug using FastAPI CLI<i></strong><br>Inside your terminal run <strong> fastapi run dev </strong><br>This will run the server in development mode with local host port 8000</p>

<h4><i>Running with Visual Studio Code Debugger</i></h3>
<p>Inside Visual Studio Code with fastapi as the workspace folder, there should be a run configuration to run the application in debug<br>This will run the server in development mode with local host port 8000 and breakpoints enabled</p>
