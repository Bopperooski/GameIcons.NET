# GameIcons.NET Library

GameIcons.NET is a .NET Standard 2.1 library that provides an extensive collection of SVG icons from the popular [game-icons.net](https://game-icons.net/) image library. This library is designed to be used primarily with the [MudBlazor](https://mudblazor.com/) library, but it can be utilized in various other projects as well. I did this for my own project, and thought that I might as well share it to save some time to the few that might need it.

## Features

- Contains all SVG icons from [game-icons.net](https://game-icons.net/).
- Icons are organized by artist names.
- Easy integration with [MudBlazor](https://mudblazor.com/).
- Usable in any .NET Standard 2.1 project.

## Installation

To use the GameIcons.NET library, download the latest release from the releases page and add the library to your project.

## Usage

After installing the library, you can use the icons in your project by including the `GameIcons.NET` namespace. Below is an example of how to use an icon in a [MudBlazor](https://mudblazor.com/) component:

```csharp
@using GameIcons.NET

<MudIcon Icon="@GameIcons.NET.Icons.SomeIcon" />
```
## Project Creation
This project was created using a PowerShell script, which is shared in the repository. You can find the script in the `scripts` directory. The script automates the process of taking the svg files from the game-icons extracted zip and convert them in C# classes.

## Namespace

The library is contained within the `GameIcons.NET` namespace. Each icon is accessible through this namespace, organized by the artist's name.

## Contributing

Contributions are welcome! If you find any issues or have suggestions for improvements, please open an issue or submit a pull request. Feel free to take the code and make your own versions as well.

## License

This project is licensed under the MIT License. See the LICENSE file for more details.

## Acknowledgements

- Icons provided by [game-icons.net](https://game-icons.net/).
- Special thanks to the artists for their amazing work.

