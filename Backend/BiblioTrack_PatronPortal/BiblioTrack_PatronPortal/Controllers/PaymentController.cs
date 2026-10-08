using BiblioTrack_PatronPortal.APIResponseWrapper;
using BiblioTrack_PatronPortal.Requests;
using Microsoft.AspNetCore.Mvc;
using PatronPortal_BusinessLogicLayer.DTOs;
using PatronPortal_BusinessLogicLayer.Interfaces;

namespace BiblioTrack_PatronPortal.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class PaymentController : BaseController
    {
        private readonly IPayment _payment;

        public PaymentController(IPayment payment)
        {
            _payment = payment;
        }

        [ProducesResponseType(typeof(ApiResponse<Dictionary<string, string>>), StatusCodes.Status200OK)]
        [ProducesResponseType(typeof(ApiResponse<string>), StatusCodes.Status400BadRequest)]
        [ProducesResponseType(typeof(ApiResponse<string>), StatusCodes.Status500InternalServerError)]
        [HttpPost("stripe-customer/{memberRecordID}")]
        public async Task<IActionResult> GetOrCreateStripeCustomer(int memberRecordID)
        {
            if (memberRecordID <= 0)
                return BadRequest(ApiResponse<string>.Fail("A valid memberRecordID is required."));

            try
            {
                var result = await _payment.GetOrCreateStripeCustomer(memberRecordID);

                if (result == null)
                    return Ok(ApiResponse<Dictionary<string, string>>.Fail("Patron not found."));

                return Ok(ApiResponse<Dictionary<string, string>>.Ok(result));
            }
            catch (Exception ex)
            {
                return HandleException(ex);
            }
        }

        [ProducesResponseType(typeof(ApiResponse<PaymentIntentDTO>), StatusCodes.Status200OK)]
        [ProducesResponseType(typeof(ApiResponse<string>), StatusCodes.Status400BadRequest)]
        [ProducesResponseType(typeof(ApiResponse<string>), StatusCodes.Status500InternalServerError)]
        [HttpPost("payment-intent")]
        public async Task<IActionResult> CreatePaymentIntent([FromBody] CreatePaymentIntentRequest request)
        {
            if (string.IsNullOrWhiteSpace(request.StripeCustomerId))
                return BadRequest(ApiResponse<string>.Fail("A valid stripeCustomerId is required."));

            if (request.AmountDue <= 0)
                return BadRequest(ApiResponse<string>.Fail("amountDue must be greater than zero."));

            try
            {
                var result = await _payment.CreatePaymentIntent(request.StripeCustomerId, request.AmountDue);
                return Ok(ApiResponse<PaymentIntentDTO>.Ok(result));
            }
            catch (Exception ex)
            {
                return HandleException(ex);
            }
        }

        [ProducesResponseType(typeof(ApiResponse<FinalizePaymentResultDTO>), StatusCodes.Status200OK)]
        [ProducesResponseType(typeof(ApiResponse<string>), StatusCodes.Status400BadRequest)]
        [ProducesResponseType(typeof(ApiResponse<string>), StatusCodes.Status500InternalServerError)]
        [HttpPost("finalize")]
        public async Task<IActionResult> FinalizePayment([FromBody] FinalizePaymentRequest request)
        {
            if (request.MemberRecordID <= 0)
                return BadRequest(ApiResponse<string>.Fail("A valid memberRecordID is required."));

            if (request.FineRecordID <= 0)
                return BadRequest(ApiResponse<string>.Fail("A valid fineRecordID is required."));

            if (string.IsNullOrWhiteSpace(request.PaymentIntentId))
                return BadRequest(ApiResponse<string>.Fail("A valid paymentIntentId is required."));

            try
            {
                var result = await _payment.FinalizePayment(request.MemberRecordID, request.FineRecordID, request.PaymentIntentId);

                if (!result.Success)
                    return Ok(ApiResponse<FinalizePaymentResultDTO>.Fail(
                        "Fine not found, already paid, or does not belong to this patron."));

                return Ok(ApiResponse<FinalizePaymentResultDTO>.Ok(result));
            }
            catch (Exception ex)
            {
                return HandleException(ex);
            }
        }
    }
}