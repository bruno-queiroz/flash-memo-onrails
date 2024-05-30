import React from "react";

import { Provider } from "react-redux";
import { store } from "./global-state/store";

import { BrowserRouter } from "react-router-dom";
import { SpaRoutes } from "./routes";

import { QueryClient, QueryClientProvider } from "@tanstack/react-query";
import { CRUDNotification } from "./components/CRUDNotification";

const queryClient = new QueryClient({
  defaultOptions: {
    queries: {
      refetchOnWindowFocus: false,
    },
  },
});

export const App = ({ isUserSignedIn }: { isUserSignedIn: boolean }) => {
  return (
    <QueryClientProvider client={queryClient}>
      <Provider store={store}>
        <CRUDNotification />
        <BrowserRouter>
          <SpaRoutes isUserSignedIn={isUserSignedIn} />
        </BrowserRouter>
      </Provider>
    </QueryClientProvider>
  );
};
