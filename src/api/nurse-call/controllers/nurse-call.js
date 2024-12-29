'use strict';

/**
 * nurse-call controller
 */

const { createCoreController } = require('@strapi/strapi').factories;

module.exports = createCoreController('api::nurse-call.nurse-call');
