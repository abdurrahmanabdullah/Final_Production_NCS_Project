'use strict';

/**
 * ns1 service
 */

const { createCoreService } = require('@strapi/strapi').factories;

module.exports = createCoreService('api::ns1.ns1');
