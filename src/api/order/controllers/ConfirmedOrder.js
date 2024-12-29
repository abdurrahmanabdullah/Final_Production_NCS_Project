'use strict';

/**
 * A set of functions called "actions" for `ConfirmedOrder`
 */

module.exports = {
  Confirm: async (ctx, next) => {
    try {
      ctx.body = 'ok';
    } catch (err) {
      ctx.body = err;
    }
  }
};
