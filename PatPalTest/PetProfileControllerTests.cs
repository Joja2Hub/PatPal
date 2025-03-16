using System.Net.Http;
using System.Text;
using System.Threading.Tasks;
using Xunit;

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
            System.Text.Json.JsonSerializer.Serialize(petData),
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
        var responseObject = System.Text.Json.JsonSerializer.Deserialize<dynamic>(responseBody);

        Assert.Equal("Success", responseObject["Status"].ToString());
        Assert.Contains("Pet profile for Buddy has been successfully created.", responseObject["Message"].ToString());
    }
}
