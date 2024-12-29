'use strict';

/**
 * nurse-call router
 */

const { createCoreRouter } = require('@strapi/strapi').factories;

module.exports = createCoreRouter('api::nurse-call.nurse-call');
