# **MMaterial** - A Material Design Library for Qt

[![Stars](https://img.shields.io/github/stars/MarkoStanojevic12/MMaterial)](https://github.com/MarkoStanojevic12/MMaterial/stargazers)

**MMaterial** is a Qt library that provides **Material Design** components for building modern and visually appealing applications. It aims to enhance the native Qt experience with a sleek, customizable, and consistent **Material Design** look.

## 🚀 **Getting Started**

This repository contains the core library, designed to be integrated into your Qt projects. If you're looking to experiment with the components or see them in action, check out the **Material-Qt-Tester** repository:

🔗 **[Material-Qt-Tester](https://github.com/MarkoStanojevic12/Material-Qt-Tester)** - A dedicated testing environment where you can try out and experiment with all the features of **MMaterial**.

---

## 📦 **Installation**

### **Clone the Repository**

```sh
git clone https://github.com/MarkoStanojevic12/MMaterial.git
```

### **Add to Your Qt Project**

Modify your `CMakeLists.txt` file to include **MMaterial**:

```cmake
add_subdirectory(MMaterial)
set_target_properties(MMaterialLib PROPERTIES AUTOMOC ON)
```

## 📚 **Available Submodules**

MMaterial provides various submodules that can be imported and used within your Qt applications. Below is a list of available submodules:

- `MMaterial.UI` - Core UI components & predefined Material themes
- `MMaterial.Controls` - Extended material-styled controls
- `MMaterial.Media` - Built-in Material icons, images, and media formating tools
- `MMaterial.Charts` - Size guidelines for Material components
- `MMaterial.Network` - Components that use the network in one way or another

To use a specific submodule, import it in your QML file:

```qml
import MMaterial.UI as UI

UI.Overline {
    text: qsTr("Hello World")
    color: UI.Theme.text.secondary
    font.pixelSize: UI.Size.pixel16
}
```

---

## 🛠️ **Development & Testing**

If you want to test **MMaterial** without integrating it into your project immediately, visit **[Material-Qt-Tester](https://github.com/MarkoStanojevic12/Material-Qt-Tester)**, which provides a ready-made environment for experimentation.

---

## 📜 **License**

This project is licensed under the **MIT License** - see the [LICENSE](LICENSE) file for details.

---

## ⭐ **Contribute & Support**

- If you find this project useful, consider giving it a **star ⭐** on GitHub!
- **Contributions, issues, and feature requests are welcome!**
- Feel free to **submit a pull request** or **open an issue**.

---

**Happy coding!** 🎨🚀



