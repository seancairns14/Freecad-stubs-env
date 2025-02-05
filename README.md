---

# **FreeCAD Conda Environment Setup**

This repository provides scripts to set up a **Conda environment** for **FreeCAD development** with proper environment variables. It includes **Windows (BAT) and Linux/macOS (SH) scripts** for seamless configuration.

## **Features**
- Automated **Conda environment creation** using `freecad-stubs-env.yml`
- **Environment variables** (`PYTHONPATH`, `FREECAD_LIB`, etc.) set up automatically
- **Persistent activation/deactivation scripts** (`activate.d` and `deactivate.d`)
- **Cross-platform support** (Windows & Linux/macOS)
- **VS Code integration** for FreeCAD development

---

## **Installation & Setup**

### **1. Clone the Repository**
```sh
git clone https://github.com/seancairns14/freecad-conda-setup.git
cd freecad-conda-setup
```

### **2. Install Conda (If Not Installed)**
Ensure **Anaconda** or **Miniconda** is installed.  
🔗 [Download Miniconda](https://docs.conda.io/en/latest/miniconda.html)

### **3. Run the Setup Script**
#### **Windows (PowerShell or CMD)**
```cmd
setup.bat
```

#### **Linux/macOS (Bash)** (**UNTESTED**)
```sh
chmod +x setup.sh
./setup.sh
```

### **4. Activate the Environment**
After running the setup script, restart your terminal and run:
```sh
conda activate freecad-stubs-env && code .
```
### **5. Run FreeCAD**
You can run freecad by running in the activated terminal:
```sh
FreeCAD
```
---

## **Project Structure**
```
freecad-conda-setup/
│── create_env/
│   ├── create_env.bat       # Windows script to create the Conda environment
│   ├── create_env.sh        # Linux/macOS script to create the Conda environment
│── setup.bat                # Windows setup script
│── setup.sh                 # Linux/macOS setup script
│── freecad-stubs-env.yml     # Conda environment YAML file
│── README.md                 # Project documentation
```

---

## **How It Works**
1. **Creates a Conda environment** (`freecad-stubs-env`) from `freecad-stubs-env.yml`
2. **Sets up activation/deactivation scripts** to configure `PYTHONPATH`
3. **Adds FreeCAD paths** automatically when activating the environment
4. **Deactivates** and cleans up paths when the environment is exited

---

## **Customization**
Modify `freecad-stubs-env.yml` to add additional dependencies.

Example (`freecad-stubs-env.yml`):
```yaml
name: freecad-stubs-env
dependencies:
  - python=3.9
  - freecad
  - numpy
  - pip
  - pip:
      - freecad-stubs
```

---

## **Troubleshooting**
### **Environment Already Exists**
If you see:
```
CondaValueError: prefix already exists
```
Manually remove the environment:
```sh
conda remove --name freecad-stubs-env --all
```
Then, rerun the setup script.

### **VS Code FreeCAD Autocomplete Not Working?**
Ensure VS Code uses the correct interpreter:
1. Open Terminal and activate env:  ```conda activate freecad-stubs-env ```
2. (**IMPORTANT**) Open **VS Code** using command: ```code . ``` 
3. Ensure that **`freecad-stubs-env`** is selected interpreter

---

## **Contributing**
Feel free to submit pull requests or report issues! 🚀

---

## **License**
This project is licensed under the **MIT License**. See [LICENSE](LICENSE) for details.

---