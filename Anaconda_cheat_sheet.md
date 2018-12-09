**_get the list of all installed packages in current environment_**
> conda list

**_Search a package_**
> conda search package_name

**_Install a package_**
> conda install package_name

**_Create an virtual environment_**
> conda create --name environment_name

**Note**:
+ This environment uses the same version of Python that you are currently using, because you did not specify a version. To use a different version use `conda create -n myenv python=3.4` or whatever version of python you want
+ After using this command there will be no globally installed package, you have to install them.

**_get the list of environments_**
> conda env list

**_Activate an environment_**
> activate environment_name

**_Removing an environmrnt_**
> conda remove --name myenv
