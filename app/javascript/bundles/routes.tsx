import React from "react";

import { Route, Routes } from "react-router-dom";

import { Decks } from "./pages/Decks";
import { AddCard } from "./pages/AddCard";
import { SearchCards } from "./pages/SearchCards";
import { Study } from "./pages/Study";

export default (
  <Routes>
    <Route path="/decks" element={<Decks />} />
    <Route path="/add" element={<AddCard />} />
    <Route path="/search" element={<SearchCards />} />
    <Route path="/study/:deckTitle" element={<Study />} />
  </Routes>
);
