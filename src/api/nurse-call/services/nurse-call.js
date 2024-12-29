'use strict';

/**
 * nurse-call service
 */

const { createCoreService } = require('@strapi/strapi').factories;

module.exports = createCoreService('api::nurse-call.nurse-call');
