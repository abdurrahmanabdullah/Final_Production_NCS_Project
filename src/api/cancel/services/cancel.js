'use strict';

/**
 * cancel service
 */

const { createCoreService } = require('@strapi/strapi').factories;

module.exports = createCoreService('api::cancel.cancel');
