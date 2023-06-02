local ls = require("luasnip")
local fmta = require("luasnip.extras.fmt").fmta

return {
  ls.snippet(
    { 
      trig = "log",
      description = "Add a console.log() statement"
    },
    fmta("console.log(<>)", { i(1) })
  ),

  ls.snippet(
    { 
      trig = "info",
      description = "Add a this.logger.info() statement"
    },
    fmta("this.logger.info(<>)", { i(1) })
  ),

  
  ls.snippet(
    { 
      trig = "warn",
      description = "Add a this.logger.warn() statement"
    },
    fmta("this.logger.warn(<>)", { i(1) })
  ),

  
  ls.snippet(
    { 
      trig = "error",
      description = "Add a this.logger.error() statement"
    },
    fmta("this.logger.error(<>)", { i(1) })
  ),

}
