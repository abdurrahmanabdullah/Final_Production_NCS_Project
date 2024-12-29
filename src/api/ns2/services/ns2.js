'use strict';

/**
 * ns2 service
 */

const { createCoreService } = require('@strapi/strapi').factories;

module.exports = createCoreService('api::ns2.ns2');
