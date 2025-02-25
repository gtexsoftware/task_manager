// These functions are used by modules that wants to interact with the dropdown component

// The dropdown component is listening to the dropdown:close event to close itself
export const closeDropdown = () => document.dispatchEvent(new CustomEvent("dropdown:close", { bubbles: true }))