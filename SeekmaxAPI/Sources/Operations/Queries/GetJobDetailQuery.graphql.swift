// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class GetJobDetailQuery: GraphQLQuery {
  public static let operationName: String = "GetJobDetail"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query GetJobDetail($jobId: String!) { job(id: $jobId) { __typename _id positionTitle description salaryRange { __typename min max } location industry haveIApplied } }"#
    ))

  public var jobId: String

  public init(jobId: String) {
    self.jobId = jobId
  }

  public var __variables: Variables? { ["jobId": jobId] }

  public struct Data: SeekmaxAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { SeekmaxAPI.Objects.Query }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("job", Job?.self, arguments: ["id": .variable("jobId")]),
    ] }

    public var job: Job? { __data["job"] }

    /// Job
    ///
    /// Parent Type: `Job`
    public struct Job: SeekmaxAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { SeekmaxAPI.Objects.Job }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("_id", String?.self),
        .field("positionTitle", String?.self),
        .field("description", String?.self),
        .field("salaryRange", SalaryRange?.self),
        .field("location", Int?.self),
        .field("industry", Int?.self),
        .field("haveIApplied", Bool?.self),
      ] }

      public var _id: String? { __data["_id"] }
      public var positionTitle: String? { __data["positionTitle"] }
      public var description: String? { __data["description"] }
      public var salaryRange: SalaryRange? { __data["salaryRange"] }
      public var location: Int? { __data["location"] }
      public var industry: Int? { __data["industry"] }
      public var haveIApplied: Bool? { __data["haveIApplied"] }

      /// Job.SalaryRange
      ///
      /// Parent Type: `SalaryRange`
      public struct SalaryRange: SeekmaxAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { SeekmaxAPI.Objects.SalaryRange }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("min", Int?.self),
          .field("max", Int?.self),
        ] }

        public var min: Int? { __data["min"] }
        public var max: Int? { __data["max"] }
      }
    }
  }
}
