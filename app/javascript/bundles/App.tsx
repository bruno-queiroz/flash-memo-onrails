import React from "react";

import { Provider } from "react-redux";
import { store } from "./global-state/store";

import { BrowserRouter } from "react-router-dom";
import routes from "./routes";

import { QueryClient, QueryClientProvider } from "@tanstack/react-query";

const queryClient = new QueryClient();

export const App = () => {
  return (
    <QueryClientProvider client={queryClient}>
      <Provider store={store}>
        <BrowserRouter>{routes}</BrowserRouter>
      </Provider>
    </QueryClientProvider>
  );
};