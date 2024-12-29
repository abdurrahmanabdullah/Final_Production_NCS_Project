module.exports = {
  routes: [
    {
      method: "GET",
      path: "/nurse-call/nurse",
      handler: "nurse.index",
      //    config: {
      //      policies: [],
      //      middlewares: [],
      //    },
    },
  ],
};
