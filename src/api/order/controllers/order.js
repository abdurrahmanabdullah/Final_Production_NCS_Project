
'use strict';

/**
 * order controller
 */

const { createCoreController } = require('@strapi/strapi').factories;

module.exports = createCoreController('api::order.order',({strapi})=>({
confirmOrder:async(ctx,next)=>{
    //ctx.body="ok";

    const{id}=ctx.params;
    console.log(ctx.state);
    const order=await strapi.entityService.findOne("api::order.order",id);
    console.log(order);
    return id;
},

}));
