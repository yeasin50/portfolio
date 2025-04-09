package models

import (
	"encoding/json"
	"net/http"
)

type APIResponse struct {
	Success bool        `json:"success"`
	Data    interface{} `json:"data,omitempty"`
	Error   *APIError   `json:"error,omitempty"`
	Meta    interface{} `json:"meta,omitempty"`
}

type APIError struct {
	Code    string      `json:"code"`
	Message string      `json:"message"`
	Details interface{} `json:"details,omitempty"`
}

func NewApiError(message string, details interface{}) APIError {
	return APIError{
		Code:    "400",
		Message: message,
		Details: &details,
	}

}

// Deprecated: Use APIResponse instead.
type ErrorResponse struct {
	Error  string            `json:"error"`
	Fields map[string]string `json:"fields"`
}

func WriteJson(w http.ResponseWriter, status int, v any) {
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(status)
	json.NewEncoder(w).Encode(v)
}

func WriteError(w http.ResponseWriter, err APIError) {
	if err.Code == "" {
		err.Code = "400"
	}

	WriteJson(w, http.StatusBadRequest, APIResponse{
		Success: false,
		Error: &APIError{
			Code:    err.Code,
			Message: err.Message,
			Details: err.Details,
		},
	})
}

func WriteOk(w http.ResponseWriter, v any) {
	WriteJson(
		w,
		http.StatusOK,
		APIResponse{
			Success: true,
			Data:    v,
		},
	)
}
