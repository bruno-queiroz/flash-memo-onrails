import React from "react";

import { Route, Routes } from "react-router-dom";

import { Decks } from "./pages/Decks";

export default (
  <Routes>
    <Route path="/decks" element={<Decks />} />
  </Routes>
);
