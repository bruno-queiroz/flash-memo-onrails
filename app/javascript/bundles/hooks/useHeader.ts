import { useEffect, useState } from "react";
import { deleteSignOut } from "../fetch/deleteSignOut";

export const useHeader = (isUserSignedIn: boolean) => {
  const [isLoggingOut, setIsLoggingOut] = useState(false);
  const [isNavActive, setIsNavActive] = useState(false);
  const [isDarkMode, setIsDarkMode] = useState(true);

  const changeTheme = () => {
    document.documentElement.classList.toggle("dark");
    localStorage.setItem("theme", !isDarkMode ? "dark" : "light");
    setIsDarkMode(!isDarkMode);
  };

  const logOut = async () => {
    setIsLoggingOut(false);
    await deleteSignOut();
    setIsLoggingOut(true);
  };

  useEffect(() => {
    if (
      localStorage.theme === "dark" ||
      (!("theme" in localStorage) &&
        window.matchMedia("(prefers-color-scheme: dark)").matches)
    ) {
      document.documentElement.classList.add("dark");
      setIsDarkMode(true);
    } else {
      document.documentElement.classList.remove("dark");
      setIsDarkMode(false);
    }
  }, []);

  return {
    isNavActive,
    isDarkMode,
    isLoggingOut,
    setIsNavActive,
    changeTheme,
    logOut,
  };
};
