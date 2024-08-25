// vue.config.js
module.exports = {
  configureWebpack: {
    resolve: {
      alias: {
        vue$: 'vue/dist/vue.esm-bundler.js'
      }
    }
  },
  chainWebpack: config => {
    config.plugin('define').tap(args => {
      const v = JSON.stringify(require('./package.json').version)
      args[0]['__VUE_PROD_HYDRATION_MISMATCH_DETAILS__'] = v
      return args
    })
  }
}