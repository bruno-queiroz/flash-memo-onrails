import { useState } from "react";
import { deleteSignOut } from "../fetch/deleteSignOut";

export const useHeader = () => {
  const [isLoggingOut, setIsLoggingOut] = useState(false);
  const [isNavActive, setIsNavActive] = useState(false);
  const [isDarkMode, setIsDarkMode] = useState(true);

  const changeTheme = () => {
    document.documentElement.classList.toggle("dark");
    // localStorage.setItem("theme", !isDarkMode ? "dark" : "light");
    setIsDarkMode(!isDarkMode);
  };

  const logOut = async () => {
    setIsLoggingOut(false);
    await deleteSignOut();
    setIsLoggingOut(true);
  };

  return {
    isNavActive,
    isDarkMode,
    isLoggingOut,
    setIsNavActive,
    changeTheme,
    logOut,
  };
};
