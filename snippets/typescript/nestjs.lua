local ls = require("luasnip")
local fmta = require("luasnip.extras.fmt").fmta

return {
  ls.snippet(
    { 
      trig = "service",
      description = "Add a new nestjs service class"
    },
    fmta(
      [[
        import { Injectable, Inject } from "@nestjs/common"
        import { Logger } from "winston"
        import { WINSTON_MODULE_PROVIDER } from "nest-winston"

        /**
         * The <>Service solves stuff
         */
        @Injectable()
        export class <>Service {
          private readonly logger: Logger
          constructor(@Inject(WINSTON_MODULE_PROVIDER) logger: Logger) {
            this.logger = logger.child({ context: <>Service.name })
          }
        }
      ]]
      , { rep(1), i(1), rep(1) })
  ),
}
