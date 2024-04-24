// The source code including full typescript support is available at:
// https://github.com/shakacode/react_on_rails_demo_ssr_hmr/blob/master/config/webpack/development.js

const { devServer, inliningCss } = require("shakapacker");
const ForkTSCheckerWebpackPlugin = require("fork-ts-checker-webpack-plugin");

const webpackConfig = require("./webpackConfig");

const developmentEnvOnly = (clientWebpackConfig, _serverWebpackConfig) => {
  // plugins
  clientWebpackConfig.plugins.push(new ForkTSCheckerWebpackPlugin());

  if (inliningCss) {
    // Note, when this is run, we're building the server and client bundles in separate processes.
    // Thus, this plugin is not applied to the server bundle.

    // eslint-disable-next-line global-require
    const ReactRefreshWebpackPlugin = require("@pmmmwh/react-refresh-webpack-plugin");
    clientWebpackConfig.plugins.push(
      new ReactRefreshWebpackPlugin({
        overlay: {
          sockPort: devServer.port,
        },
      })
    );
  }
};

module.exports = webpackConfig(developmentEnvOnly);
