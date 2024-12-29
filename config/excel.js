



// module.exports = {
//     config: {
  
//       "api::order-report.order-report": {
//         columns: [
//           "slug",
//           "FirstName",
//           "LastName",
//           "Address",
//           "Mobile",
//           "Email",
//           "City",
//           "Zone",
//           "Comment",
//           "orderId",
//         ],
//         relation: {
//           solution: {
//             column: ["title"],
//           },
//         },




module.exports = {
    config: {
  
      "api::nurse-call.nurse-call": {
        columns: [
          
          "msg"
         
        ],
        relation: {
          solution: {
            column: ["msg"],
          },
        },
        // Relations and locale are currently not supported for nested data like OrderList
        locale: false, // Again, ensure it's a boolean
      },
    },
  };
  