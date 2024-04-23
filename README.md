<!-- Improved compatibility of back to top link: See: https://github.com/othneildrew/Best-README-Template/pull/73 -->
<a name="readme-top"></a>
<!--
*** Thanks for checking out the Best-README-Template. If you have a suggestion
*** that would make this better, please fork the repo and create a pull request
*** or simply open an issue with the tag "enhancement".
*** Don't forget to give the project a star!
*** Thanks again! Now go create something AMAZING! :D
-->



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
[![Issues][issues-shield]][issues-url]
[![MIT License][license-shield]][license-url]
[![LinkedIn][linkedin-shield]][linkedin-url]



<!-- PROJECT LOGO -->
<br />
<div align="center">
  <a href="https://github.com/jpyamamoto/shorty">
    <img src="images/logo.png" alt="Logo" width="80" height="80">
  </a>

<h3 align="center">Shorty</h3>

  <p align="center">
    URL shortener
    <br />
  </p>
</div>



<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#roadmap">Roadmap</a></li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
  </ol>
</details>



<!-- ABOUT THE PROJECT -->
## About The Project

[![Shorty Screenshot][product-screenshot]](https://github.com/jpyamamoto/shorty)

A simple URL shortener made in Elixir, with the Phoenix Framework.

<p align="right">(<a href="#readme-top">back to top</a>)</p>



### Built With

* [![Elixir][Elixir]][Elixir-url]
* [![Phoenix][Phoenix]][Phoenix-url]
* [![Tailwind.CSS][TailwindCSS]][TailwindCSS-url]

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- GETTING STARTED -->
## Getting Started

This is an example of how you may give instructions on setting up your project locally.

To get a local copy up and running follow these simple example steps.

### Prerequisites

- Elixir installation

### Installation

To start your Phoenix server:

1. Run `mix setup` to install and setup dependencies
2. Start Phoenix endpoint with mix `phx.server` or inside IEx with `iex -S mix phx.server`
3. Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

The server runs with a SQLite database, so no steps to setup the database are necessary.

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- USAGE EXAMPLES -->
## Usage

### Browser

This project can be used through the browser, with the input that will shorten a URL.

### API

To shorten a new link:

```
# POST /api/new

{"url": "http://example.com"}
```

To retrieve the information about a shortened URL:

```
# GET /api/:key
```

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- ROADMAP -->
## Roadmap

- [x] Cache with ETS tables
- [x] Browser and API
- [ ] Analytics
    - [x] Number of visits

See the [open issues](https://github.com/jpyamamoto/shorty/issues) for a full list of proposed features (and known issues).

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- CONTRIBUTING -->
## Contributing

Contributions are what make the open source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also simply open an issue with the tag "enhancement".
Don't forget to give the project a star! Thanks again!

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- LICENSE -->
## License

Distributed under the MIT License. See `LICENSE.txt` for more information.

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- CONTACT -->
## Contact

Juan Pablo Yamamoto - [@jpyamamoto](https://github.com/jpyamamoto) - jpyamamoto@ciencias.unam.mx

Project Link: [https://github.com/jpyamamoto/shorty](https://github.com/jpyamamoto/shorty)

<p align="right">(<a href="#readme-top">back to top</a>)</p>




<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/jpyamamoto/shorty.svg?style=for-the-badge
[contributors-url]: https://github.com/jpyamamoto/shorty/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/jpyamamoto/shorty.svg?style=for-the-badge
[forks-url]: https://github.com/jpyamamoto/shorty/network/members
[stars-shield]: https://img.shields.io/github/stars/jpyamamoto/shorty.svg?style=for-the-badge
[stars-url]: https://github.com/jpyamamoto/shorty/stargazers
[issues-shield]: https://img.shields.io/github/issues/jpyamamoto/shorty.svg?style=for-the-badge
[issues-url]: https://github.com/jpyamamoto/shorty/issues
[license-shield]: https://img.shields.io/github/license/jpyamamoto/shorty.svg?style=for-the-badge
[license-url]: https://github.com/jpyamamoto/shorty/blob/master/LICENSE.txt
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url]: https://linkedin.com/in/linkedin_username
[product-screenshot]: screen.png
[Phoenix]: https://img.shields.io/badge/phoenixframework-000000?style=for-the-badge&logo=nextdotjs&logoColor=white
[Phoenix-url]: https://www.phoenixframework.org/
[Elixir]: https://img.shields.io/badge/elixir-000000?style=for-the-badge&logo=nextdotjs&logoColor=white
[Elixir-url]: https://elixir-lang.org/
[TailwindCSS]: https://img.shields.io/badge/elixir-000000?style=for-the-badge&logo=nextdotjs&logoColor=white
[TailwindCSS-url]: https://tailwindcss.com/
