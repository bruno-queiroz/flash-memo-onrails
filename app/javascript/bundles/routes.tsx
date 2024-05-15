import React from "react";

import { Route, Routes } from "react-router-dom";

import { Decks } from "./pages/Decks";
import { AddCard } from "./pages/AddCard";

export default (
  <Routes>
    <Route path="/decks" element={<Decks />} />
    <Route path="/add" element={<AddCard />} />
  </Routes>
);
