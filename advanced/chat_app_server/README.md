# Prerequisites
This project requires **Node.js v20.17.0**. You can manage the installation of different Node.js versions using [nvm-windows](https://github.com/coreybutler/nvm-windows). Make sure you have it installed before proceeding.

You can check the list of installed versions with the command `nvm list`. If you don't have that version installed, follow the steps below:

### Installing Node.js with nvm-windows
1. Download and install **nvm-windows** from the [official repository](https://github.com/coreybutler/nvm-windows).
2. Run the following commands to install and use **Node.js v20.17.0**:

    ```bash
    nvm install 20.17.0
    nvm use 20.17.0
    ```

# Run server
`>npm run start:dev`

`>nodemon start:dev`

# Node dependencies for the server

`npm install nodemon --save-dev`

`npm i bcryptjs cors express-validator jsonwebtoken mongoose`

- **bcryptjs:** Encrypt passwords
- **cors:** Cross domain requests
- **express-validator:** Validation of fields (password, user, etc.)
- **jsonwebtoken:** JsonWeb Tokens
- **mongoose:** Database
