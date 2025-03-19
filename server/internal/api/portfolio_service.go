package api

import (
	"encoding/json"
	"fmt"
	"net/http"
	"os"
	"path/filepath"
	"strconv"

	"github.com/gin-gonic/gin"
	"github.com/yeasin50/portfolio/internal/models"
)

type portfolioService struct {
}

func NewPortfolioService() portfolioService {
	return portfolioService{}
}

func (s *portfolioService) RegisterRoutes(r *gin.Engine) {
	r.GET("/projects", s.GetProject)
	r.GET("/connect_option", s.GetConnectOption)
	r.GET("/user_info", s.GetUserInfo)
}

func (s *portfolioService) GetConnectOption(ctx *gin.Context) {
	s.getJsonResponse(ctx, "connect_option.json")
}

func (s *portfolioService) GetUserInfo(ctx *gin.Context) {
	s.getJsonResponse(ctx, "user_info.json")
}

// / general method to handle request
func (s *portfolioService) getJsonResponse(ctx *gin.Context, fileName string) {
	data, err := getLocalJson(fileName)
	if err != nil {
		models.WriteError(ctx.Writer, *err)
		return
	}

	var jsonData map[string]interface{}
	if err := json.Unmarshal([]byte(data), &jsonData); err != nil {
		models.WriteError(ctx.Writer, models.APIError{
			Code:    strconv.Itoa(http.StatusInternalServerError),
			Message: fmt.Sprintf("error unmarshaling JSON: %v", err),
		})
		return
	}

	models.WriteJson(ctx.Writer, http.StatusAccepted, jsonData)
}

// GetLocalJson reads a JSON file from /database/json/ and returns its content as a string.
func getLocalJson(fileName string) (string, *models.APIError) {
	filePath := filepath.Join("database", "json", fileName)

	data, err := os.ReadFile(filePath)
	if err != nil {
		info := models.APIError{
			Code:    strconv.Itoa(http.StatusInternalServerError),
			Message: fmt.Sprintf("error reading file %s: %v", filePath, err),
		}
		return "", &info
	}

	return string(data), nil
}
