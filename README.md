# ColorPicker

<a name="readme-top"></a>

<!-- PROJECT SHIELDS -->
<!--
*** I'm using markdown "reference style" links for readability.
*** Reference links are enclosed in brackets [ ] instead of parentheses ( ).
*** See the bottom of this document for the declaration of the reference variables
*** for contributors-url, forks-url, etc. This is an optional, concise syntax you may use.
*** https://www.markdownguide.org/basic-syntax/#reference-style-links
-->

[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![MIT License][license-shield]][license-url] 
[![Issues][issues-shield]][issues-url]


<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
        <li><a href="#built-with">Prerequisites</a></li>
        <li><a href="#built-with">Optional Prerequisites</a></li>
      </ul>
    </li>
    <li><a href="#usage">How to Build</a></li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#roadmap">Roadmap</a></li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#acknowledgments">Acknowledgments</a></li>
  </ol>
</details>


## About The Project

![![Qt Qml Color Picker][product-screenshot]](docs/colorPicker.png)

Simple Color Picker made with QtQuick

### Features
+ Color Wheel
+ Color Tool
+ Color Picker
+ Color History
+ RGBA Slider
+ HSVA Slider

<p align="right">(<a href="#readme-top">back to top</a>)</p>


### Built With  
[![Qt-Shield]][Qt-url]  
[![Kubuntu]][Kubuntu-url]  

### Prerequisites  
+ [Qt 6.2.X +](https://www/qt.io)  
+ [CMake 3.16 +](https://cmake.org/)  

#### Optional Prerequisites  
+ Ninja 1.10.X +
  
<p align="right">(<a href="#readme-top">back to top</a>)</p>


## How to Build
``` shell
mkdir build
cd build
cmake -S .. -G Ninja -DCMAKE_PREFIX_PATH=<YOUR_PATH_HERE>/Qt/<YOUR_QT_VERSION_HERE>/gcc_64
ninja
```
<p align="right">(<a href="#readme-top">back to top</a>)</p>

## Usage

+ Shortcuts  
  + Enable Picking Tool **" p "**
  + Change Value
    +  The **" + "** increase 0.1 to the actual value, it can be combined with **" Shift "** for more precise changes
    +  The **" - "** decrease 0.1 to the actual value, it can be combined with **" Shift "** for more precise changes
  + Mouse Wheel inside sliders

<p align="right">(<a href="#readme-top">back to top</a>)</p>


## Roadmap

- [x] Remove QCursor dependency
- [ ] Add Wayland support
- [ ] Add OpenColorIO to manager color spaces
- [ ] Add HSL Slider
- [ ] Add support to choose between 8Bits [0-255] and 32Bits [0-1] range
- [ ] Add Color Swatches
    - [ ] Add new swatch
    - [ ] Edit current Selected
    - [ ] Save swatch palette
    - [ ] Open swatch palette
- [ ] Multi-language Support
    - [ ] Portuguese (PT/BR)
    - [ ] Spanish
    - [ ] Franch



<p align="right">(<a href="#readme-top">back to top</a>)</p>


## License

Distributed under the MIT License. See [`LICENSE`][license-url] for more information.

<p align="right">(<a href="#readme-top">back to top</a>)</p>



## Contact

**André Agenor**

[![LinkedIn][linkedin-shield]][linkedin-url]
[![Twitter][Twitter-shield]][Twitter-url]

Project Link: [https://github.com/andreagen0r/ColorPicker](https://github.com/andreagen0r/ColorPicker)
<p align="right">(<a href="#readme-top">back to top</a>)</p>


<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/andreagen0r/ColorPicker.svg?color=44cc11&style=for-the-badge
[contributors-url]: https://github.com/andreagen0r/ColorPicker/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/andreagen0r/ColorPicker.svg?color=0075bb&style=for-the-badge
[forks-url]: https://github.com/andreagen0r/ColorPicker/network/members
[stars-shield]: https://img.shields.io/github/stars/andreagen0r/ColorPicker.svg?color=0075bb&style=for-the-badge
[stars-url]: https://github.com/andreagen0r/ColorPicker/stargazers
[issues-shield]: https://img.shields.io/github/issues/andreagen0r/ColorPicker.svg?color=dfb317&style=for-the-badge
[issues-url]: https://github.com/andreagen0r/ColorPicker/issues
[license-shield]: https://img.shields.io/github/license/andreagen0r/ColorPicker.svg?color=97ca00&style=for-the-badge
[license-url]: https://github.com/andreagen0r/ColorPicker/blob/main/LICENSE
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url]: https://www.linkedin.com/in/andreagenor
[product-screenshot]: https://img.youtube.com/vi/g_IjqsMMFks/0.jpg

[Qt-Shield]: https://img.shields.io/badge/Tested%20with-6.4.1-%233ebc4d?style=for-the-badge&logo=Qt
[Qt-url]: https://www.qt.io

[Kubuntu]: https://img.shields.io/badge/Tested%20with-Kubuntu%2022.04-%230075bb?style=for-the-badge&logo=Kubuntu
[Kubuntu-url]: https://kubuntu.org/

[Twitter-shield]: https://img.shields.io/twitter/url?color=1da1f2&logo=twitter&style=for-the-badge&url=https%3A%2F%2Ftwitter.com%2Fandreagenor
[Twitter-url]: https://twitter.com/andreagenor





