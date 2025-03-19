package api

import (
	"encoding/json"
	"fmt"
	"log"
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

func (s *portfolioService) GetProject(ctx *gin.Context) {

	data, err := getLocalJson("projects.json")
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

	projectsData, ok := jsonData["data"].([]interface{})
	if !ok {
		models.WriteError(ctx.Writer, models.APIError{
			Code:    strconv.Itoa(http.StatusInternalServerError),
			Message: "invalid structure for 'data' in JSON",
		})
		return
	}

	var projects []models.Project
	for _, p := range projectsData {
		projectMap, ok := p.(map[string]interface{})
		if !ok {
			models.WriteError(ctx.Writer, models.APIError{
				Code:    strconv.Itoa(http.StatusInternalServerError),
				Message: "invalid project structure in JSON",
			})
			return
		}

		projectJSON, err := json.Marshal(projectMap)
		if err != nil {
			models.WriteError(ctx.Writer, models.APIError{
				Code:    strconv.Itoa(http.StatusInternalServerError),
				Message: fmt.Sprintf("error marshaling project: %v", err),
			})
			return
		}

		var project models.Project
		if err := json.Unmarshal(projectJSON, &project); err != nil {
			models.WriteError(ctx.Writer, models.APIError{
				Code:    strconv.Itoa(http.StatusInternalServerError),
				Message: fmt.Sprintf("error unmarshaling project: %v", err),
			})
			return
		}

		if project.Thumbnail != nil {
			m := fullPath(*project.Thumbnail)
			project.Thumbnail = &m
		}

		projects = append(projects, project)
	}

	models.WriteOk(ctx.Writer, projects)
}

var basDir *string

func fullPath(m models.Media) models.Media {
	if basDir == nil {
		dir, err := os.Getwd()
		if err != nil {
			log.Fatalf("failed to get OS path %v", err)
			return m
		}

		basDir = &dir
	}
	m.Url = filepath.Join(*basDir, "database", "images", m.Url)
	return m
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

	models.WriteOk(ctx.Writer, jsonData)
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
