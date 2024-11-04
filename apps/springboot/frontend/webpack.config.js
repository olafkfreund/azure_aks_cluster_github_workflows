// frontend/webpack.config.js
const path = require('path');

module.exports = {
  entry: './src/main/js/app.js',
  devtool: 'source-map',
  mode: 'development',
  resolve: {
    alias: {
      'stompjs': path.resolve(__dirname, 'node_modules/stompjs/lib/stomp.js'),
    }
  },
  output: {
    path: path.resolve(__dirname, 'build'),
    filename: 'bundle.js',
    publicPath: '/'
  },
  module: {
    rules: [
      {
        test: /\.(js|jsx)$/,
        exclude: /node_modules/,
        use: ['babel-loader']
      }
    ]
  },
  devServer: {
    contentBase: path.join(__dirname, 'public'),
    compress: true,
    port: 3000,
    historyApiFallback: true,
    proxy: {
      '/api': 'http://localhost:8080'
    }
  }
};