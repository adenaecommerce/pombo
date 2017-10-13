# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

## [1.0.3] - 2017-10-13

#### Changed
- Add service Encomenda for PAC and SEDEX
- Update project changelog to Keep a Changelog format


## [1.0.2] - 2017-05-09

#### Fixed
- Fix Correios services' codes changes


## [1.0.1] - 2016-11-06

#### Fixed
- Send to log the parameters sent to the webservice
- Fix the method "str_real_to_float" to work with numbers above thousand
_ Add zip code not found error #999


## [1.0.0] - 2016-05-14

#### Added

- It allows you to change the default settings
- It allows you to change the runtime settings
- Allows the creation of packages with items
- It is used to quote a package even if it does not reach the minimum dimensions
- Allows the service value of consultation
- Allows consultation of service delivery time
- It allows you to see the value and service delivery time
- It supports internationalization
- Accepts a logger compatible with the interface [Log4r](http://log4r.rubyforge.org/index.html)
