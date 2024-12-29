"use strict";

/**
 * product controller
 */

const { createCoreController } = require("@strapi/strapi").factories;

module.exports = createCoreController("api::nurse-call.nurse-call", () => ({
  async index(ctx, next) {
    ctx.send({ msg: "true" });
    //  ctx.body="HEllo World";
  },
}));
////----------------------------------------------
// "use strict";

// /**
//  * nurse-call controller
//  */

// const { createCoreController } = require("@strapi/strapi").factories;

// let currentState = true; // Initial state

// module.exports = createCoreController("api::nurse-call.nurse-call", ({ strapi }) => ({
//   async index(ctx) {
//     ctx.send({ msg: currentState });
//   },

//   async updateState(ctx) {
//     const { action } = ctx.request.body;

//     if (action === "call") {
//       currentState = true;
//     } else if (action === "cancel") {
//       currentState = false;
//     } else {
//       return ctx.send({ msg: "Invalid action" }, 400);
//     }

//     ctx.send({ msg: currentState });
//   }
// }));
