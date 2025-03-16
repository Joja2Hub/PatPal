using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Net.Http;
using System.Text;
using System.Threading.Tasks;
using Xunit;
using System.Text.Json;

namespace Pat
{
    public class PetProfileControllerTests
    {
        [Fact]
        public async Task AddPetProfile_ValidData_ReturnsSuccessResponse()
        {
            // Arrange (подготовка тестовых данных)
            var controller = new PetProfileController();

            var petData = new
            {
                Name = "Buddy",
                Species = "Dog",
                Breed = "Golden Retriever",
                DateOfBirth = "2020-05-15",
                Gender = "Male",
                PhotoURL = "https://example.com/pet-photo.jpg"
            };

            var jsonContent = new StringContent(
                JsonSerializer.Serialize(petData),
                Encoding.UTF8,
                "application/json"
            );

            var request = new HttpRequestMessage(HttpMethod.Post, "/api/pets")
            {
                Content = jsonContent
            };

            // Act (выполнение метода)
            var response = await controller.AddPetProfile(request);

            // Assert (проверка результата)
            Assert.Equal(System.Net.HttpStatusCode.Created, response.StatusCode);

            var responseBody = await response.Content.ReadAsStringAsync();
            var responseObject = JsonSerializer.Deserialize<JsonElement>(responseBody);

            // Проверка значений через GetProperty
            Assert.Equal("Success", responseObject.GetProperty("Status").GetString());
            Assert.Contains("Pet profile for Buddy has been successfully created.", responseObject.GetProperty("Message").GetString());
        }
    }

}
